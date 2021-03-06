#! /bin/sh

set -e

# These version are ok, pre-1.7 is not.  Post 1.7 may produce a lot of
# warnings for unrelated projects, so prefer 1.7 for now.

# 1.7 caused weird am__remove_distdir on my env. So I made 1.10 most
# preferable.  -- YamaKen 2006-12-25
am_version=
for v in 1.11 1.10 1.7 1.9 1.8; do
    if type -p &>/dev/null automake-$v; then
	am_version="-$v"
	break
    fi
done
if [ -z "$am_version" ]; then
    case "`automake --version`" in
	*\ 0.*|*\ 1.[0-6].*|*\ 1.[0-6]\ *)
	    echo "$0: Automake-1.7 or later is needed."
	    exit 2
	    ;;
    esac
fi

set -x
libtoolize --automake --force --copy
aclocal$am_version -I m4
automake$am_version -ac
autoconf
set +x
echo
echo "Ready to run './configure'."
echo
