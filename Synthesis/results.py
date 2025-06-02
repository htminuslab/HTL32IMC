import argparse

def extract_resource_summary(file_path, start_marker, end_marker):
    """Reads a file and prints lines between custom start and end markers, handling multiple occurrences."""
    extracting = False

    with open(file_path, 'r', encoding='utf-8') as file:
        for line in file:
            line = line.strip()

            if start_marker in line:  # Match start marker
                extracting = True
                continue  # Skip the marker itself
            elif end_marker in line:  # Match end marker
                extracting = False
                print()  # Separate different sections
                continue  # Skip the marker itself
            
            if extracting:
                print(line)

# Command-line argument setup
parser = argparse.ArgumentParser(description="Extract text between specified markers from a file.")
parser.add_argument("file_path", type=str, help="Path to the input text file")
parser.add_argument("start_marker", type=str, help="Start marker text")
parser.add_argument("end_marker", type=str, help="End marker text")
args = parser.parse_args()

extract_resource_summary(args.file_path, args.start_marker, args.end_marker)