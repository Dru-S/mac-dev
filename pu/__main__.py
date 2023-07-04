import sys
import argparse
import yaml
import os
import re
import time
import pathlib
from datetime import datetime, timezone

#

PATH_SCRIPT = '/'.join(str.split(__file__, '/')[:-1])
PATH_RES = f'{PATH_SCRIPT}/resources'
PATH_TMP = f'{PATH_SCRIPT}/_tmp'

HELP_TODO   = 'Create a `~todo.md` and `~toinf.md` for a project'
HELP_PAGE   = 'Create page files (Twig in \`views\` and Yaml)'
HELP_SHARED = 'Create shared files (Twig in \`views/shared\`, SCSS and \`@import\` in \`main.scss\`)'
HELP_START  = 'Launch a series of command to quickly start a project'

# 

START_FILE = 'start.yml'
START_YAML = {}

# Common functions
def write_file(path, content = None):
	# Check if the path to the file exists, only if the file it's inside a subdirectory
	path_dir = os.path.dirname(path)
	if path_dir and not os.path.isdir(path_dir):
		pathlib.Path(path_dir).mkdir(parents=True, exist_ok=True)

	fp = open(path, 'w')
	if (content): fp.write(content)
	fp.close()

def remove_file(path):
	os.remove(path)

#

def handle_todo(arg):
	name = arg

	# If no name is specified, get the name from the current project's directory
	if (name == 1):
		name = os.getcwd() # Get current directory
		name = str.split(name, '/').pop() # Get the last directory of the CWD
		name = re.sub('(-|_)', ' ', name) # Replace all '-' with ' ' (spaces)
		name = name.capitalize() # Capitalize the first letter of the name

	# Create content, by setting the heading, the "type" of the file, and an empty checkbox
	heading = f'# {name}'
	checkbox = '\n- []'
	content_todo = f'{heading}\n\n## `://TODO`{checkbox}'
	content_toinf = f'{heading}\n\n## `://TOINF`{checkbox}'

	# Create `~todo.md` and `~toinf.md` files, and write the correct content
	write_file('~todo.md', content_todo)
	write_file('~toinf.md', content_toinf)
	print('Created `~todo.md` and `~toinf.md` files in ' + os.getcwd())

#

def handle_start(args):
	global START_YAML
	
	if (not START_YAML): start_get_yaml()

	commands = []
	for arg in args:
		for command in START_YAML[arg]['commands']:
			commands.append(command)
	
	commands = '\n'.join(list(commands));
	filename = f"{int(datetime.now().timestamp())}.zsh"

	write_file(f"{PATH_TMP}/{filename}", commands)
	os.system(f"""/bin/zsh {PATH_TMP}/{filename}""")
	remove_file(f"{PATH_TMP}/{filename}")

def start_map_commands(c):
	return '/bin/zsh ' + c

def start_get_yaml():
	global START_YAML
	with open(f'{PATH_RES}/{START_FILE}', 'r') as file:
		try: START_YAML = yaml.safe_load(file)
		except yaml.YAMLError as exc: print(exc)

#

def handle_component(arg):
	# Prepare all names, for file and class
	filename         = re.sub('(\s|_)', '-', arg).lower()
	css_suffix_class = re.sub('-', '_', filename)
	css_content      = f'.sn_{css_suffix_class} {{\n\t\n}}\n'
	css_import       = f'@import \'shared/{filename}\';\n'
	main_path        = '_src/stylesheets/main.scss'

	# Create Twig file
	write_file(f'views/shared/{filename}.twig')

	# Create Scss file
	write_file(f'_src/stylesheets/shared/{filename}.scss', css_content)

	# Append the `@import` of the newly crated file, in `main.scss`
	# Appen it only after the last `@import 'shared/*';`, so if the last import
	# of the file is a subfolder of shared, or a different folder, the component
	# will be appended in the right position
	last_index = -1;
	last_line = '';
	lines = []

	# Read the `main.scss`
	with open(main_path, 'r') as reader: lines = reader.readlines()

	# Cycle through the lines, and find the last "shared"
	for ii, line in enumerate(lines):
		if re.search('@import \'shared/([^/]*)?\';', line):
			last_index = ii;
			last_line  = line;

	# Appena the import after the last shared, and create the new file content
	last_line += css_import
	lines[last_index] = last_line
	main_content = ''.join(lines)

	# Write the file
	write_file(main_path, main_content)

#

def handle_page(arg):
	print('HANDLE PAGE')
	# Prepare all names, for file and class
	filename = re.sub('(\s|_)', '-', arg).lower()

	# Create Twig file
	write_file(f'views/{filename}.twig')

	# If `fixtures` directory exists, it's a WP Boilerplate and create the
	# Yaml file inside it. Else, if `fixtures` directory doesn't exists, it means
	# it's a Frontend Boilerplate, and create the Yaml inside '_src/yaml'
	if os.path.isdir('fixtures'):
		write_file(f'fixtures/yaml/{filename}.yml')
	else:
		write_file(f'_src/yaml/{filename}.yml')
	
#
#
#

def main():
	parser = argparse.ArgumentParser()
	
	# Add arguments
	parser.add_argument('-t', '--todo',
		action='store', nargs='?', const=1,
		help=HELP_TODO)

	parser.add_argument('-p', '--page',
		action='store',
		help=HELP_SHARED)

	parser.add_argument('-c', '--component', '--shared',
		action='store',
		help=HELP_SHARED)

	parser.add_argument('-s', '--start',
		action='store', nargs='*',
		help=HELP_START)

	args = parser.parse_args()
	# print(args)

	# Handle arguments
	if (args.todo):      handle_todo(args.todo)
	if (args.page):      handle_page(args.page)
	if (args.component): handle_component(args.component)
	if (args.start):     handle_start(args.start)

#

if __name__ == '__main__': main()