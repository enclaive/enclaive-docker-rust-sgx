<div align="center">
# Gramine Rust Proof of Concept

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![License][license-shield]][license-url]
[![Last Commit][last-commit-shield]][last-commit-url]

This repository is a small demo to show, how to run a rust application inside an Intel SGX enclave with Gramine.

[About The Project](#about-the-project) •
[Getting started](#getting-started) •
[Gramine Rust Image structure](#gramine-rust-image-structure) •
[Modifying the PoC](#modifying-the-poc-to-run-an-other-rust-application)
</div>



## About The Project

With the increasing movement to the cloud and zero-trust infrastructure, the field of confidential computing is becoming increasingly important for developers. With Gramine, an existing code base can be migrated quickly and easily without the need for a complete re-write.

The project was developed in the context of the system security lecture by [@sebastiangajek](https://github.com/sebastiangajek) at the Flensburg University of Applied Sciences.
## Getting started
### Pre-requirements
The system has to support Intel SGX. Check this with
```sh
grep sgx /proc/cpuinfo
```
or have a look at [Intel's Guide](https://www.intel.com/content/www/us/en/support/articles/000028173/processors.html) to find out.

Please consider Intels [linux SGX driver](https://github.com/intel/linux-sgx-driver) for install instructions, if needed.

Docker and Docker Compose are also necessary for this poc, for installation consider the [Docker documentation](https://docs.docker.com/get-docker/) for your OS.
### Running the PoC
After fulfilling the pre-requirements, clone the repository and run the following inside the project
```sh
docker-compose up
```
Under `http://{your_ip_address}` you should be greeted by your enclave.

## Gramine Rust Image structure
### Build 

### Run
[entrypoint script](entrypoint.sh) is exectuted on container start to get the required token and launches the application

## Modifying the PoC to run an other rust application

## License
This project is distributed under the GPLv3 License. See `LICENSE` for further information.

## Acknowledgments

This project greatly celebrates all contributions from the gramine team and the amazing progress made by the [enclaive](https://github.com/enclaive) team.

* [enclaive.io](https://github.com/enclaive)
* [gramine-os Docker Image](https://hub.docker.com/r/enclaive/gramine-os)
* [Gramine Project](https://github.com/gramineproject)
* [Intel SGX](https://github.com/intel/linux-sgx-driver)
* [Best-README-Template](https://github.com/othneildrew/Best-README-Template)



[contributors-shield]: https://img.shields.io/github/contributors/Smil3yFace/docker-gramine-rust?style=for-the-badge
[contributors-url]: https://github.com/Smil3yFace/docker-gramine-rust/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Smil3yFace/docker-gramine-rust.svg?style=for-the-badge
[forks-url]: https://github.com/Smil3yFace/docker-gramine-rust/network/members
[stars-shield]: https://img.shields.io/github/stars/Smil3yFace/docker-gramine-rust.svg?style=for-the-badge
[stars-url]: https://github.com/Smil3yFace/docker-gramine-rust/stargazers
[license-shield]: https://img.shields.io/github/license/Smil3yFace/docker-gramine-rust.svg?style=for-the-badge
[license-url]: https://github.com/Smil3yFace/docker-gramine-rust/blob/main/LICENSE
[last-commit-shield]:https://img.shields.io/github/last-commit/Smil3yFace/docker-gramine-rust/main.svg?style=for-the-badge
[last-commit-url]: https://github.com/Smil3yFace/docker-gramine-rust/commits/main
[log-img]: images/enclave-hmtl-output.png



