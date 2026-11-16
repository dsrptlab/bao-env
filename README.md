# bao-env

Loads a service's secrets from OpenBao (AppRole, KV v2) into the environment at start, then runs the service command.

```dockerfile
COPY --from=openbao/openbao:2.7.2 /usr/bin/bao /usr/local/bin/bao
ADD --chmod=755 https://raw.githubusercontent.com/dsrptlab/bao-env/v4/bao-env /opt/bao/bao-env
ADD --chmod=644 https://raw.githubusercontent.com/dsrptlab/bao-env/v4/agent.hcl /opt/bao/agent.hcl
ENTRYPOINT ["/opt/bao/bao-env", "<original command>"]
```

Container env: `BAO_ROLE_ID`, `BAO_SECRET_ID`, `BAO_SECRET_PATHS` (comma-separated paths under `secret/`). OpenBao is reached at `http://openbao:8200` on the docker network `openbao`.
