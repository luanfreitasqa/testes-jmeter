# Usa uma imagem oficial do JMeter
FROM justb4/jmeter:5.5

# Copia os arquivos de teste para dentro do container
COPY ./jmeter-tests/ /opt/jmeter/tests/

# Define o ponto de entrada do container
ENTRYPOINT ["jmeter", "-n", "-t", "/opt/jmeter/tests/Test Plan South.jmx", "-l", "/opt/jmeter/results/results.jtl"]