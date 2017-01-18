FROM rhel 

MAINTAINER Samuel Terburg

ENV  FILTER   "broker-discovery=yes"
ENV  TEMPLATE "/templates/route.tpl"

COPY watch.sh   /watch.sh
COPY templates/ /templates/
RUN curl -sSL https://github.com/openshift/origin/releases/download/v1.3.2/openshift-origin-client-tools-v1.3.2-ac1d579-linux-64bit.tar.gz | tar -C /usr/local/bin/ -xzv --strip-components=1 */oc

CMD /watch.sh

