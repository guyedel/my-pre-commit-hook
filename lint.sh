#!/bin/sh

CONFIG_FILE=".lint-config.json"

should_run() {
  config_name=$1
  if [ ! -f $CONFIG_FILE ]; then
      return 0
  fi
  value=$(jq -e ".$config_name" $CONFIG_FILE)
  if [ "$value" = "\"disable\"" ]; then
      echo "[!] $config_name is disabled"
      return 1
  fi
  return 0
}

if should_run "black"; then
    echo "[+] Running black"
    black --line-length 120 $@
    black_retval=$?
    if [ $black_retval -ne 0 ]; then
        echo "black failed with exit code $black_retval"
        exit $black_retval
    fi
fi

if should_run "isort"; then
  echo "[+] Running isort"
  isort --profile black $@
  isort_retval=$?
  if [ $isort_retval -ne 0 ]; then
      echo "isort failed with exit code $isort_retval"
      exit $isort_retval
  fi
fi

if should_run "flake8"; then
  echo "[+] Running flake8"
  flake8 --config /configs/.flake8 $@
  flake8_retval=$?
  if [ $flake8_retval -ne 0 ]; then
      echo "flake8 failed with exit code $flake8_retval"
      exit $flake8_retval
  fi
fi

exit 1
