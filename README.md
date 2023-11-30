# Private Tangle

This folder contains a Docker-based setup to run your own development private Tangle. The steps to run a private tangle
are:

## Requirements
1. A recent release of Docker enterprise or community edition. You can find installation instructions in the [official Docker documentation](https://docs.docker.com/engine/install/).
2. [Docker Compose CLI plugin](https://docs.docker.com/compose/install/compose-plugin/).

## Steps

1. `./bootstrap.sh` this will bootstrap your own private tangle by creating the genesis snapshot and required files.
   - _**Note:** If you are running this from inside the repository, you should run `./bootstrap.sh build` to re-build the docker images after any updates to the HORNET codebase (e.g. changing files or pulling git changes)_ 
2. Create env files:
   - .coordinator_env with coordinator keys seperated by commas with value 
     ```COO_PRV_KEYS=```
   - .postgres_env with credentials for postgres with values
     ```
     POSTGRES_USER=
     POSTGRES_PASSWORD=
     ```
3. Run:
   - `./run.sh` to run 2 nodes + COO.
   - `./run.sh 3` to run 3 nodes + COO.
   - `./run.sh 4` to run 4 nodes + COO.

3. `./cleanup.sh` to clean up all generated files and start over. 


## Start the coordinator in case of failure

The `inx-coordinator` container always starts together with the other containers if you execute the `./run.sh` command.
It may happen that the node startup takes longer than expected due to bigger databases or slow host machines. In that case the `inx-coordinator` container shuts down and won't be restarted automatically for security reasons.

If you want to restart the `inx-coordinator` separately, run the following command:
```sh
docker compose start inx-coordinator
```
