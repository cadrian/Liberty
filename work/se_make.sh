#!/bin/sh
#--
#-- This file is part of SmartEiffel The GNU Eiffel Compiler Tools and Libraries.
#-- See the Copyright notice at the end of this file.
#--
#
# Use this script to install a tool in SE_BIN.
#
# Usage: se make <tool> <options>...
#

CHECK_LEVEL=-require_check
DIR=require
DEBUG=false
SEDB=false
NOGC=false
OPTIONS=''
TOOL=compile_to_c
BUILD=true

while [ $# -gt 0 ]; do
    case x"$1" in
        x-no_check|x--no_check|x/no_check)
            CHECK_LEVEL=$1
            DIR=no
            ;;
        x-require_check|x--require_check|x/require_check)
            CHECK_LEVEL=$1
            DIR=require
            ;;
        x-ensure_check|x--ensure_check|x/ensure_check)
            CHECK_LEVEL=$1
            DIR=ensure
            ;;
        x-invariant_check|x--invariant_check|x/invariant_check)
            CHECK_LEVEL=$1
            DIR=invariant
            ;;
        x-loop_check|x--loop_check|x/loop_check)
            CHECK_LEVEL=$1
            DIR=loop
            ;;
        x-all_check|x--all_check|x/all_check)
            CHECK_LEVEL=$1
            DIR=all
            ;;
        x-boost|x--boost|x/boost)
            CHECK_LEVEL=$1
            DIR=boost
            ;;
        x-debug|x--debug|x/debug)
            DEBUG=true
            OPTIONS="$OPTIONS $1"
            ;;
        x-sedb|x--sedb|x/sedb)
            SEDB=true
            OPTIONS="$OPTIONS $1"
            ;;
        x-no_gc|x--no_gc|x/no_gc)
            NOGC=true
            OPTIONS="$OPTIONS $1"
            ;;
        x-no_build|x--no_build|x/no_build)
            BUILD=false
            ;;
        x-version|x--version|x/version)
            if [ x$SMART_EIFFEL_SHORT_VERSION = x1 ]; then
                echo "Release 2011.07 (LibertyEiffel revival)"
            else
                cat <<EOF
Version of command "se_make.sh" is:
SmartEiffel The GNU Eiffel Compiler, Eiffel tools and libraries
Release 2011.07 (LibertyEiffel revival)
Copyright (C), 1994-2002 - INRIA - LORIA - ESIAL UHP Nancy 1 - FRANCE
Copyright (C), 2003-2005 - INRIA - LORIA - IUT Charlemagne Nancy 2 - FRANCE
D.COLNET, P.RIBET, C.ADRIAN, V.CROIZIER F.MERIZEN - SmartEiffel@loria.fr
http://SmartEiffel.loria.fr

Copyright (C), 2011 - C.ADRIAN - cyril.adrian@gmail.com
https://github.com/LibertyEiffel/Liberty
EOF
            fi
            exit 0
            ;;
        x-*|x/*)
            OPTIONS="$OPTIONS $1"
            ;;
        *)
            TOOL=$1
            ;;
    esac
    shift
done

SE_BIN=$(grep ^bin: $HOME/.serc/liberty.se | cut -c6-)

outdir=$SE_BIN/.make/$TOOL/$DIR
if $DEBUG; then
    outdir=${outdir}.debug
fi
if $SEDB; then
    outdir=${outdir}.sedb
fi
if $NOGC; then
    outdir=${outdir}.no_gc
fi

test -d $outdir || mkdir -p $outdir
cd $outdir

if $BUILD; then
    test -d old && rm -rf old
    if [ -d new ]; then
        mkdir old
        cp -a new/$TOOL* old/
    else
        mkdir new
    fi
    cd new
    echo "Compiling $TOOL..."
    echo $SE_BIN/se compile $OPTIONS -split by_type $CHECK_LEVEL $TOOL -o $TOOL.out
    $SE_BIN/se compile $OPTIONS -split by_type $CHECK_LEVEL $TOOL -o $TOOL.out || exit 1
else
    test -d new || mkdir new
    cd new
fi

if [ -e $TOOL.out ]; then
    echo "Copying $TOOL..."
    test -e $SE_BIN/$TOOL && /bin/mv $SE_BIN/$TOOL $SE_BIN/$TOOL.old
    /bin/cp $TOOL.out $SE_BIN/$TOOL
else
    echo "$TOOL was not compiled. Keeping the older version." 2>&1
    exit 1
fi

echo "Done."

#--
#-- ------------------------------------------------------------------------------------------------------------------------------
#-- Copyright notice below. Please read.
#--
#-- SmartEiffel is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License,
#-- as published by the Free Software Foundation; either version 2, or (at your option) any later version.
#-- SmartEiffel is distributed in the hope that it will be useful but WITHOUT ANY WARRANTY; without even the implied warranty
#-- of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have
#-- received a copy of the GNU General Public License along with SmartEiffel; see the file COPYING. If not, write to the Free
#-- Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
#--
#-- Copyright(C) 1994-2002: INRIA - LORIA (INRIA Lorraine) - ESIAL U.H.P.       - University of Nancy 1 - FRANCE
#-- Copyright(C) 2003-2006: INRIA - LORIA (INRIA Lorraine) - I.U.T. Charlemagne - University of Nancy 2 - FRANCE
#--
#-- Authors: Dominique COLNET, Philippe RIBET, Cyril ADRIAN, Vincent CROIZIER, Frederic MERIZEN
#--
#-- http://SmartEiffel.loria.fr - SmartEiffel@loria.fr
#-- ------------------------------------------------------------------------------------------------------------------------------
