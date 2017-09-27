#! /bin/bash

# TODO: python. Remove the whole 3 and -doc blocks in control. Remove
# 	builddeps for 3. Remove --with python3 in rules.

set -e

# changing these so the control files are more deterministic
# (and so that patches apply properly)
export DEBFULLNAME=debianize-github
export DEBEMAIL=auto@example.com

function do_dh_make() {
	PKGS="$1"
	if [ -e 'setup.py' ]
	then
		dh_make --python -p $PKGS --createorig --yes
		# TODO: edit control and rules
	else
		if ! dh_make -s -p $PKGS --createorig --yes
		then
			PKGS="${DIRNAME}_1.0"
			dh_make -s -p $PKGS --createorig --yes
		fi
	fi
}

for URL in "$@"
do
	(
	 mkdir DEBS || true
	 cd DEBS

	 BRANCH=master
	 if echo "$URL" | grep '@'
	 then
		BRANCH=$(echo "$URL" | sed -e 's/^.*@//')
	 	URL=$(echo "$URL" | sed -e 's/@.*$//')
	 fi

	 git clone --recursive https://github.com/$URL
	 DIRNAME=$(echo $URL | sed -e 's=^.*/==')
	 cd "$DIRNAME"
	 git checkout $BRANCH
	 git checkout -b debianization
	 if [ -x ./autogen.sh ]
	 then
		./autogen.sh
	 fi
	 PKGS=$(grep ^AC_INIT configure.ac | 
		sed -e 's/^AC_INIT(\[\([^[]*\)\], *\[\([^[]*\)\].*$/\1_\2/')
	 if [ "x$PKGS" == "x" ]
	 then
	 	PKGS="${DIRNAME}_1.0"
	 fi
	 do_dh_make "$PKGS"
	 git add debian
	 COMMIT_OPTS="-c user.name=automaton -c user.email=auto@mate"
	 git $COMMIT_OPTS commit -am "created by dh_make"
	 sed -i -e 's/\t\(dh .*$\)/\t\1 --parallel/' debian/rules
	 git $COMMIT_OPTS commit -am "parallelize builds"
	 if [ -e ../../patches/$URL ]
	 then
		 git $COMMIT_OPTS am ../../patches/$URL/*.patch
	 fi
	)
done

