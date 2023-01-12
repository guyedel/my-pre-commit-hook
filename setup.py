# mypy: ignore-errors
from setuptools import find_packages, setup

main_namespace = {}
with open("hook/version.py") as version_file:
    exec(version_file.read(), main_namespace)
version = main_namespace["__version__"]

setup(
    name="hook",
    version=version,
    packages=find_packages(),
    package_data={},
    install_requires=open("./reqs_for_setup.txt").readlines(),
)
