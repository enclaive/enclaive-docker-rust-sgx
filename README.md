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
[Gramine Rust Image structure](#gramine-Rust-image-structure) •
[Modifying the PoC](#modifying-the-poc-to-run-another-Rust-application)
</div>


## About The Project
With the increasing movement to the cloud and zero-trust infrastructure, the field of confidential computing is becoming increasingly important for developers. With Gramine, an existing code base can be migrated quickly and easily without the need for a complete re-write.

This project was developed in the context of the system security lecture by [@sebastiangajek](https://github.com/sebastiangajek) at the Flensburg University of Applied Sciences.

## Getting started
### Pre-requirements
An enclave-ready computing platform with flexible launch control. Check for Intel SGX with
```sh
grep sgx /proc/cpuinfo
```
and look for the flags `sgx` and `sgx_lc` or have a look at [Intel's Guide](https://www.intel.com/content/www/us/en/support/articles/000028173/processors.html) to find it out.

In addition, Intel SGX drivers are necessary. They are integrated in Linux kernel version 5.11. If there is a kernel version 5.9 or higher in use, install [Intel SGX DCAP](https://github.com/intel/SGXDataCenterAttestationPrimitives).

Docker and Docker Compose are also necessary for this PoC, for installation consider the [Docker documentation](https://docs.docker.com/get-docker/) for your OS.

### Running the PoC
After fulfilling the pre-requirements, clone the repository and run the following inside the project
```sh
docker-compose up
```
Under `http://{your_host_ip}` you should be greeted by your enclave, after the console prints `Server is running`.

## Gramine Rust Image structure
### Build 
The build process of the image contains two Stage
* First Stage ("builder"): Uses the official Rust docker image to compile the [project](hello_world) to an executable using cargo
* Second Stage: Gathers all additional required resources, generates the manifest form [template](rust.manifest.template) and signs it 

During build `ARG projectName` specifies the name of the project directory and executable. Further 
`ARG webFiles` specifies the directory for *.html, *.js, ... . Both are defined in the [docker-compose.yml](docker-compose.yml)

If more packages are required during build or runtime they can be added to the `package.txt` or `build/package.txt`
to install them during build.

After the build finished the app environment looks this by default
```
/app/
 + $projeckName #executable
 + $webFiles/
    + *.html
```

### Run
The [entrypoint.sh](entrypoint.sh) is executed on container start to get the required token and launches the application

## Modifying the PoC to run another Rust application
To run another Rust executable it is enough to replace the `hello_world` project with yours and change the argument `projectName` in [docker-compose.yml](docker-compose.yml) to your project name.
Same applies for the argument `webFiles` or if not needed, this part can be removed.

**Note:** After the image is build the `$webFiles` are located in `/app/$webFiles/`.

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



