# -----------------------------
# Stage 1: Build / prepare assets
# -----------------------------
FROM alpine:latest AS builder

RUN apk add --no-cache curl bash
WORKDIR /site

COPY index.html .
COPY style.css .

# -----------------------------
# Stage 2: Runtime (Tomcat)
# -----------------------------
FROM tomcat:9.0

# Remove default webapps to avoid clutter
RUN rm -rf /usr/local/tomcat/webapps/*

# Create custom folder inside webapps
RUN mkdir -p /usr/local/tomcat/webapps/openedition

# Copy site files into openedition folder
COPY --from=builder /site/index.html /usr/local/tomcat/webapps/openedition/
COPY --from=builder /site/style.css /usr/local/tomcat/webapps/openedition/

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8080/openedition/ || exit 1

CMD ["catalina.sh", "run"]
