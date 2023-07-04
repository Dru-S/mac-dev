#!/bin/bash

# Get $name as an argument of the command
NAME=$2

# Functions
trim() {
  # Trim string, before* and after**
  STRING="${1##*( )}" # *
  STRING="${STRING%%*( )}" # **
  echo $STRING
}

capitalize() {
	IFS=" "
	ARRAY=($1)
	RESULT="";
	for STRING in "${ARRAY[@]}";
	do
		# echo "${STRING:0:1})${STRING:1}"
		TMP="$(tr '[:lower:]' '[:upper:]' <<< ${STRING:0:1})${STRING:1}"
		RESULT="$RESULT $TMP"
		# echo "\n"
	done

	echo $RESULT
}

# -p -> PAGE
# -c, -s -> COMPONENT/SHARED -> COMPONENT
# -t -> `~todo.md` `~toinf.md`

while getopts 'pscth' c; do
  case $c in
    # PAGE
    p)
      # Create Twig file
      touch views/$NAME.twig

      if [[ -d "fixtures" ]]
      # If "fixtures" directory exists, it's a WP and create the Yaml inside it
      then touch fixtures/yaml/$NAME.yml
      # If "fixtures" directory doesn't exists, it's a Frontend and create the Yaml inside '_src/yaml'
      else touch _src/yaml/$NAME.yml
      fi
      ;;

    # COMPONENT
    s|c)
      # Create Twig file
      touch views/shared/$NAME.twig

      # Create and add SCSS file
      touch _src/stylesheets/shared/_$NAME.scss
      printf ".sn_${NAME//-/_} {\n\t\n}\n" > _src/stylesheets/shared/_$NAME.scss
      printf "@import 'shared/${NAME}';\n" >> _src/stylesheets/main.scss
      ;;

    # TODO & TOINF
    t)
      # Get current directory name, most of the times also the project name
      PROJ=$(trim $(capitalize "${PWD##*/}"))

      # Create the 2 files
      touch '~todo.md'
      touch '~toinf.md'

      # Print the first line of the files, with the project name
      printf "# ${PROJ/-/\s}\n\n## \`://TODO\`" > '~todo.md'
      printf "# ${PROJ/-/\s}\n\n## \`://INFO\`" > '~toinf.md'
      ;;

    # HELP
    h)
      # Print the help message
      echo "┌─────────────────────────────┐"
      echo "│ Project Utils - Bash Script │"
      echo "└─────────────────────────────┘"
      echo "-p        Create page files (Twig in \`views\`, Yaml)"
      echo "-c, -s    Create shared files (Twig in \`views/shared\`, SCSS and \`@import\` in \`main.scss\`)"
      echo "-t        Create \`~todo.md\` and \`~toinf.md\` files"
      ;;

  esac
done
