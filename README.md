This repository allows you to work with submodules in the Container by sending them as regular folders.
This is a temporary solution that can be used as a workaround for this problem: [Problem](https://github.com/orgs/portainer/discussions/9767)

## Usage
1. Clone the repository.
2. Assign environment variables as well as volumes to ssh keys and project path in the `docker-compose.yaml` file.
3. Run with `docker compose up --build`
