FROM meteorhacks/meteord:base

COPY ./ /app
RUN bash $METEORD_DIR/on_build.sh
