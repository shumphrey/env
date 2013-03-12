## Run 5 tests at a time in colour
export HARNESS_OPTIONS="j5:c"

## Always use cpanm
alias cpan="cpanm"
export PERL_CPANM_OPT="--prompt"

## Handy pretty print TAP test function
function t {
  VENDOR_LIBS=""
  if [[ -d vendor ]]; then
    for dir in vendor/*/lib
    do
      VENDOR_LIBS=( ${VENDOR_LIBS[@]} "-I$dir" )
    done
  fi

  if [[ -d blib ]]; then
    perl -Mblib ${VENDOR_LIBS[@]} -MTest::Pretty "$@"
  else
    perl -Ilib ${VENDOR_LIBS[@]} -MTest::Pretty "$@"
  fi
}

## I store all my projects in a directory called projects
## Auto set PERL5LIB to those libs
for dir in ~/Projects/*/lib
do
    PLIBS=( ${PLIBS[@]}":$dir" )
done
export PERL5LIB="${PLIBS[@]}"

## Use perlbrew
if [[ -d "/opt/perl5" ]]; then
    export PERLBREW_ROOT=/opt/perl5
fi
source $PERLBREW_ROOT/etc/bashrc
