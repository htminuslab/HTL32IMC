import sys
import re

def update_xml_parameter(xml_file, param_path, new_value):
    try:
        # Read the XML file as a regular text file
        with open(xml_file, 'r', encoding='utf-8') as file:
            xml_content = file.read()

        # Split the param_path to get section and parameter
        sections = param_path.split(".")
        if len(sections) != 2:
            print("Invalid parameter format. Expected 'section.param=value'.")
            return
        
        section_name = sections[0]  # e.g., 'place_and_route'
        param_info = sections[1].split("=")
        if len(param_info) != 2:
            print("Invalid parameter format. Expected 'section.param=value'.")
            return
        param_name = param_info[0]  # e.g., 'placer_effort_level'
        param_value = param_info[1]  # e.g., '3'

        # Find the section to modify (e.g., <efx:place_and_route>)
        section_search = f"<efx:{section_name}"
        section_start_index = xml_content.find(section_search)
        if section_start_index == -1:
            print(f"Error: Section '{section_name}' not found in XML.")
            return
        
        # Find the end of the section by locating the closing tag
        section_end_index = xml_content.find(f"</efx:{section_name}>", section_start_index)
        if section_end_index == -1:
            print(f"Error: Closing tag for '{section_name}' not found.")
            return
        
        # Extract the content of the section
        section_content = xml_content[section_start_index:section_end_index]

        # Search for the specific <efx:param name="parameter_name" inside that section
        param_search = f'<efx:param name="{param_name}"'
        param_value_search = f'value="{new_value}"'
        param_value_search_old = f'value="'

        # Check if the parameter exists inside the section
        param_start_index = section_content.find(param_search)
        if param_start_index == -1:
            print(f"Parameter '{param_name}' not found under section '{section_name}'.")
            return
        
        # Find and replace the value part of the parameter
        param_value_start_index = section_content.find(param_value_search_old, param_start_index)
        if param_value_start_index != -1:
            param_value_end_index = section_content.find('"', param_value_start_index + len(param_value_search_old))
            # Replace the old value with the new value
            section_content = section_content[:param_value_start_index + len(param_value_search_old)] + new_value + section_content[param_value_end_index:]

            print(f"Updated '{param_name}' to {new_value}.")

            # Now, we reconstruct the full XML content with the modified section
            xml_content = xml_content[:section_start_index] + section_content + xml_content[section_end_index:]

            # Write the updated content back to the XML file
            with open(xml_file, 'w', encoding='utf-8') as file:
                file.write(xml_content)
            print(f"XML file '{xml_file}' updated successfully!")
        else:
            print(f"Error: Parameter '{param_name}' has no 'value' attribute to update.")

    except Exception as e:
        print(f"Error: {e}")

def main():
    if len(sys.argv) != 2:
        print("Usage: python modifyxml.py <section.param=value>")
        sys.exit(1)

    # Get the parameter path (e.g., 'place_and_route.placer_effort_level=3') from command line arguments
    param_path = sys.argv[1]

    # Ensure the user provides a valid file name for XML
    xml_file = "generated_project.xml"  # Replace this with the actual file name or path
    
    # Call the function to update the XML
    update_xml_parameter(xml_file, param_path, param_path.split("=")[1])

if __name__ == "__main__":
    main()
