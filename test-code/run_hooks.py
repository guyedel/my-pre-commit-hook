import os
import sys

import black
from click import echo
from isort.main import main as isort_main
from pylint.lint import Run as PylintRun


def _get_config_file(filename: str) -> str:
    """Get the config file path."""
    return os.path.join(os.path.dirname(__file__), "configs", filename)


def main(folder: str) -> None:
    echo("Running isort")
    isort_main([folder, "--settings-path", _get_config_file("isort.cfg"), "--check"])

    echo("Running pylint")
    x = PylintRun([folder, "--rcfile", _get_config_file("pylintrc")], exit=False)
    if x.linter.msg_status:
        sys.exit(x.linter.msg_status)

    x = 5

    # Black must be last, because it's calling sys.exit() on its own
    echo("Running black")
    black.main([folder])


if __name__ == "__main__":
    sys.argv.append(".")
    echo(sys.argv)
    main(sys.argv[1])
