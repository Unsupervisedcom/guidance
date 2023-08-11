# You could use `gitpod/workspace-full` as well.
FROM gitpod/workspace-full

RUN pyenv uninstall -f 3.11.1 && \
    env PYTHON_CONFIGURE_OPTS='--enable-shared' pyenv install -f 3.10 && \
    pyenv global 3.10
    