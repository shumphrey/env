##############################
## perl
##############################

## Run 5 tests at a time in colour
#export HARNESS_OPTIONS="j5:c"
export HARNESS_OPTIONS="c"

# always do pretty print db profiling
export DBIC_TRACE_PROFILE="console"

## Always use cpanm
alias cpan="cpanm"
export PERL_CPANM_OPT="--prompt"

## open perl module in vim
function pv {
    vim `mpath $1`
}

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

# Use perlbrew
if [[ -d "/opt/perl5" ]]; then
    export PERLBREW_ROOT=/opt/perl5
else
    export PERLBREW_ROOT=~/perl5/perlbrew
fi


if [[ -d $HOME/.plenv/bin ]]; then
    export PATH="$HOME/.plenv/bin:$PATH"
    eval "$(plenv init -)"
fi

alias p="perl -E"
