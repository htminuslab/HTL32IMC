def read_params(filename):
    params = {}
    with open(filename, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith('#'):
                continue
            if '=' in line:
                key, val = line.split('=', 1)
                params[key.strip()] = val.strip()
    return params

def xml_escape(s):
    # Simple XML escape for &, <, >, ", '
    return (s.replace("&", "&amp;")
             .replace("<", "&lt;")
             .replace(">", "&gt;")
             .replace('"', "&quot;")
             .replace("'", "&apos;"))

def determine_value_type(val):
    # Determine efx:param value_type based on value format
    val_lower = val.lower()
    if val_lower in {"on", "off", "true", "false"}:
        return "e_bool"
    if val.isdigit() or (val.startswith('-') and val[1:].isdigit()):
        return "e_integer"
    if val.startswith("0x") or val.startswith("0X"):
        return "e_string"  # hex string treated as string
    # Could add more complex detection here
    return "e_option"

def generate_param_lines(params_dict, tool_prefix, indent_level=3):
    indent = "    " * indent_level
    lines = []
    for key, val in sorted(params_dict.items()):
        if key.startswith(tool_prefix + "."):
            param_name = key[len(tool_prefix)+1:]
            value_type = determine_value_type(val)
            lines.append(f'{indent}<efx:param name="{xml_escape(param_name)}" value="{xml_escape(val)}" value_type="{value_type}"/>\n')
    return lines

def generate_design_files_xml(params, indent_level=2):
    indent = "    " * indent_level
    files_xml = ""
    # Handle multiple design files numbered 1 to 100 (adjust if needed)
    for i in range(1, 100):
        base = f"design.design_file{i}"
        if f"{base}.name" in params:
            name = xml_escape(params[f"{base}.name"])
            version = xml_escape(params.get(f"{base}.version", "default"))
            library = xml_escape(params.get(f"{base}.library", "default"))
            files_xml += f'{indent}<efx:design_file name="{name}" version="{version}" library="{library}"/>\n'
    return files_xml

def generate_xml(params):
    project_attrs = {
        "name": params.get("project.name", ""),
        "description": params.get("project.description", ""),
        "last_change": params.get("project.last_change", ""),
        "sw_version": params.get("project.sw_version", ""),
        "last_run_state": params.get("project.last_run_state", ""),
        "last_run_flow": params.get("project.last_run_flow", ""),
        "config_result_in_sync": params.get("project.config_result_in_sync", ""),
        "design_ood": params.get("project.design_ood", ""),
        "place_ood": params.get("project.place_ood", ""),
        "route_ood": params.get("project.route_ood", ""),
    }

    indent0 = ""
    indent1 = "    "
    indent2 = "        "
    indent3 = "            "

    header = (
        f'<?xml version="1.0" encoding="UTF-8"?>\n'
        f'<efx:project name="{xml_escape(project_attrs["name"])}" '
        f'description="{xml_escape(project_attrs["description"])}" '
        f'last_change="{xml_escape(project_attrs["last_change"])}" '
        f'sw_version="{xml_escape(project_attrs["sw_version"])}" '
        f'last_run_state="{xml_escape(project_attrs["last_run_state"])}" '
        f'last_run_flow="{xml_escape(project_attrs["last_run_flow"])}" '
        f'config_result_in_sync="{xml_escape(project_attrs["config_result_in_sync"])}" '
        f'design_ood="{xml_escape(project_attrs["design_ood"])}" '
        f'place_ood="{xml_escape(project_attrs["place_ood"])}" '
        f'route_ood="{xml_escape(project_attrs["route_ood"])}" '
        f'xmlns:efx="http://www.efinixinc.com/enf_proj" '
        f'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '
        f'xsi:schemaLocation="http://www.efinixinc.com/enf_proj enf_proj.xsd">\n'
    )

    device_info = (
        f'{indent1}<efx:device_info>\n'
        f'{indent2}<efx:family name="{xml_escape(params.get("device.family", ""))}"/>\n'
        f'{indent2}<efx:device name="{xml_escape(params.get("device.device", ""))}"/>\n'
        f'{indent2}<efx:timing_model name="{xml_escape(params.get("device.timing_model", ""))}"/>\n'
        f'{indent1}</efx:device_info>\n'
    )

    design_info = (
        f'{indent1}<efx:design_info def_veri_version="{xml_escape(params.get("design.def_veri_version", ""))}" '
        f'def_vhdl_version="{xml_escape(params.get("design.def_vhdl_version", ""))}" '
        f'unified_flow="{xml_escape(params.get("design.unified_flow", ""))}">\n'
        f'{indent2}<efx:top_module name="{xml_escape(params.get("design.top_module", ""))}"/>\n'
        f'{generate_design_files_xml(params, indent_level=2)}'
        f'{indent2}<efx:top_vhdl_arch name="{xml_escape(params.get("design.top_vhdl_arch", ""))}"/>\n'
        f'{indent1}</efx:design_info>\n'
    )

    constraint_info = (
        f'{indent1}<efx:constraint_info>\n'
        f'{indent2}<efx:sdc_file name="{xml_escape(params.get("constraint.sdc_file", ""))}"/>\n'
        f'{indent2}<efx:inter_file name="{xml_escape(params.get("constraint.inter_file", ""))}"/>\n'
        f'{indent2}<efx:isf_file name="{xml_escape(params.get("constraint.isf_file", ""))}"/>\n'
        f'{indent1}</efx:constraint_info>\n'
    )

    empty_sections = (
        f'{indent1}<efx:sim_info/>\n'
        f'{indent1}<efx:misc_info/>\n'
        f'{indent1}<efx:ip_info/>\n'
    )

    tools = [
        ("synthesis", "efx:synthesis tool_name=\"efx_map\""),
        ("place_and_route", "efx:place_and_route tool_name=\"efx_pnr\""),
        ("bitstream_generation", "efx:bitstream_generation tool_name=\"efx_pgm\""),
        ("debugger", "efx:debugger"),
    ]

    tools_xml = ""
    for prefix, tag in tools:
        tag_name = tag.split()[0]
        tools_xml += f'{indent1}<{tag}>\n'
        param_lines = generate_param_lines(params, prefix, indent_level=3)
        if param_lines:
            tools_xml += "".join(param_lines)
        tools_xml += f'{indent1}</{tag_name}>\n'

    footer = f'</efx:project>\n'

    return header + device_info + design_info + constraint_info + empty_sections + tools_xml + footer


def main():
    params_file = "params.txt"
    output_file = "generated_project.xml"

    params = read_params(params_file)
    xml_content = generate_xml(params)

    with open(output_file, "w", encoding="utf-8") as f:
        f.write(xml_content)

    print(f"XML file '{output_file}' generated successfully.")


if __name__ == "__main__":
    main()
