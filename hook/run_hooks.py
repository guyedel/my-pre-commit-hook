import black
from click import echo
import pylint


def main():
    echo("Running black")
    black.patched_main()
    echo("Running pylint")
    pylint.run_pylint()
