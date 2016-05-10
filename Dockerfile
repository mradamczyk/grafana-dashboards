FROM grafana/grafana
MAINTAINER Michał Adamczyk <mr.adamczyk@gmail.com>

# fixes from https://github.com/percona/grafana-dashboards
RUN sed -i 's/step_input:""/step_input:c.target.step/; s/ HH:MM/ HH:mm/; s/,function(c)/,"templateSrv",function(c,g)/; s/expr:c.target.expr/expr:g.replace(c.target.expr,c.panel.scopedVars)/' /usr/share/grafana/public/app/plugins/datasource/prometheus/query_ctrl.js && sed -i 's/h=a.interval/h=g.replace(a.interval, c.scopedVars)/' /usr/share/grafana/public/app/plugins/datasource/prometheus/datasource.js

RUN sed -i '248 s/;enabled = false/enabled = true/' /etc/grafana/grafana.ini && \
    sed -i '249 s/^;//' /etc/grafana/grafana.ini

ADD dashboards /var/lib/grafana
ADD misc/Docker_System_Overview.json /var/lib/grafana/dashboards

