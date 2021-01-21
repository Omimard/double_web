[webservers]
%{ for ip in webserver ~}
${ip}
%{ endfor ~}