#!/bin/sh

test_description="System Ontology Design Pattern"


: "${SHARNESS_TEST_SRCDIR:=.}"

. "$SHARNESS_TEST_SRCDIR/sharness.sh"


TESTDIR="$SHARNESS_TEST_DIRECTORY/system"
MODULEDIR="$SHARNESS_TEST_DIRECTORY/../modules/common"
ONTDIR="$SHARNESS_TEST_DIRECTORY/../"

test_expect_failure "Test system pattern failure nodes " "
    pdm run pyshacl -m -i both -e '$MODULEDIR/system.ttl' -s '$MODULEDIR/system.shacl.ttl' '$TESTDIR/system.invalid.ttl'
"

# test_expect_failure "Test system pattern failure nodes " "
#     pdm run pyshacl -m -e '$MODULEDIR/system.ttl' -s '$MODULEDIR/system.shacl.ttl' '$TESTDIR/system.invalid.ttl' -f human
# "

# test_expect_success "Test system ontology pattern " "
#     pdm run pyshacl -m -i both -e '$MODULEDIR/system.ttl' -s '$MODULEDIR/system.shacl.ttl' '$TESTDIR/system.valid.ttl'
# "


test_done