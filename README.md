# README

## Visão Geral

Este projeto automatiza a execução de testes de performance utilizando o **Apache JMeter**, gera relatórios em HTML, publica os relatórios no **GitHub Pages** e cria um arquivo ZIP dos relatórios. O pipeline é agendado para ser executado diariamente às **18:30 no horário de Brasília**.

Para verificar os testes e o HTML do dia anterior é:
https://luanfreitasqa.github.io/testes-south-jmeter/index.html

## Pré-requisitos

- Conta no GitHub com um repositório para o projeto.
- Conhecimento básico de GitHub Actions e YAML.
- Arquivo de teste do JMeter (`.jmx`) configurado e armazenado no repositório (por exemplo, `jmeter-tests/Test Plan South.jmx`).

## Configuração do GitHub Actions

O pipeline é definido em um arquivo YAML dentro do diretório `.github/workflows/`, por exemplo, `jmeter-tests.yml`.

### Configuração do Workflow

O workflow está configurado para:

- Executar os testes do JMeter.
- Gerar o relatório em HTML.
- Comprimir o relatório em um arquivo ZIP.
- Publicar o relatório no GitHub Pages.
- Agendar a execução diária às 18:30 BRT (21:30 UTC).

## Detalhes da Configuração

### Configuração do JMeter

- **Download e Instalação**: O JMeter é baixado e instalado no runner do GitHub Actions utilizando comandos shell.
- **Processo**:
  - Baixar o arquivo de instalação do JMeter.
  - Extrair o conteúdo do arquivo baixado.
  - Mover os arquivos para o diretório `/opt/jmeter`.
  - Criar um link simbólico para facilitar o uso do comando `jmeter`.

### Execução dos Testes de Performance

- **Preparação da Pasta de Resultados**: Limpa a pasta `results` e cria o diretório `jmeter-report` para armazenar o relatório.
- **Execução dos Testes**:
  - Executa o JMeter em modo não GUI, especificando o caminho para o arquivo de teste `.jmx` e o arquivo de resultados `.jtl`.
  - Os resultados dos testes são salvos para posterior geração do relatório.

### Geração do Relatório HTML

- **Criação do Relatório**:
  - Utiliza o comando do JMeter para gerar um relatório em HTML a partir do arquivo de resultados `.jtl`.
  - O relatório é armazenado no diretório `jmeter-report`.

### Compressão do Relatório em um Arquivo ZIP

- **Criação do ZIP**:
  - Compacta o diretório do relatório em um arquivo ZIP para facilitar o download e o compartilhamento.
- **Upload como Artefato**:
  - O arquivo ZIP é disponibilizado como um artefato do workflow do GitHub Actions, permitindo que seja baixado diretamente pela interface.

### Publicação no GitHub Pages

- **Utilização da Ação**: A ação `peaceiris/actions-gh-pages@v3` é usada para publicar o relatório no GitHub Pages.
- **Configuração**:
  - Um Personal Access Token (PAT) é utilizado para autenticação e autorização para fazer push no branch `gh-pages`.
  - O diretório de publicação é definido como o local onde o relatório HTML foi gerado.
  - O relatório é publicado no branch `gh-pages`, que é usado pelo GitHub Pages para servir o conteúdo.

### Agendamento da Execução Diária

- **Configuração do Agendamento**:
  - O workflow é agendado para ser executado diariamente às 21:30 UTC, correspondendo às 18:30 no horário de Brasília.
  - O agendamento é realizado utilizando uma expressão cron no arquivo de configuração do workflow.

## Configuração do GitHub Pages

1. **Ativar o GitHub Pages**:
   - Nas configurações do repositório, acesse a seção **Pages**.
   - Selecione o branch `gh-pages` como fonte e o diretório raiz `/`.
   - Salve as configurações para ativar o GitHub Pages.

2. **Obter a URL do Site**:
   - Após a configuração, o GitHub fornecerá a URL onde o relatório será publicado.
   - A URL geralmente segue o padrão `https://<seu-usuário>.github.io/<nome-do-repositório>/`.

## Gerenciamento de Tokens e Permissões

- **Criação de um Personal Access Token (PAT)**:
  - Acesse as configurações de tokens em sua conta do GitHub.
  - Gere um novo token clássico com as permissões necessárias, selecionando a opção `repo` para acesso total ao repositório.
  - Defina uma data de expiração e dê um nome ao token para identificação.

- **Adição do Token como um Secret**:
  - No repositório, vá em **Settings** > **Secrets and variables** > **Actions**.
  - Adicione um novo secret com o nome `ACTIONS_DEPLOY_KEY` e cole o token gerado.

- **Utilização no Workflow**:
  - O token é referenciado no arquivo de configuração do workflow para autenticar ações que requerem permissão, como fazer push para o branch `gh-pages`.

## Como Acessar o Relatório

- **URL do Relatório**:
  - Após a publicação, o relatório estará disponível na URL fornecida pelo GitHub Pages.
  - Acesse o link para visualizar o relatório de performance gerado pelo JMeter.

- **Verificação**:
  - Certifique-se de que todos os recursos do relatório (gráficos, tabelas, etc.) estão carregando corretamente.
  - Se houver problemas, verifique os logs do workflow para identificar possíveis erros.

## Notas e Boas Práticas

- **Segurança**:
  - Nunca exponha tokens ou credenciais em código fonte ou logs públicos.
  - Utilize variáveis de ambiente e secrets para armazenar informações sensíveis.

- **Manutenção do Token**:
  - Lembre-se de renovar o Personal Access Token antes da data de expiração.
  - Atualize o secret no repositório com o novo token quando necessário.

- **Atualização das Ações**:
  - Mantenha as ações do GitHub Actions atualizadas para aproveitar melhorias e correções.
  - Verifique periodicamente a documentação das ações utilizadas para conhecer novas funcionalidades.

- **Agendamento e Fuso Horário**:
  - O GitHub Actions utiliza o UTC para agendamentos.
  - Ajuste a expressão cron conforme necessário, especialmente se houver mudanças no horário de verão.

- **Documentação e Logs**:
  - Mantenha uma documentação clara do processo para facilitar a manutenção e o entendimento por outros colaboradores.
  - Utilize os logs do GitHub Actions para depurar problemas e monitorar a execução dos workflows.

## Conclusão

Este guia descreve como configurar um pipeline automatizado que:

- Executa testes de performance com o Apache JMeter.
- Gera relatórios em HTML.
- Publica os relatórios no GitHub Pages para fácil acesso via web.
- Cria um arquivo ZIP dos relatórios para download.
- Agenda a execução diária do pipeline às 18:30 no horário de Brasília.

Seguindo estas instruções, você poderá replicar e adaptar a configuração conforme as necessidades do seu projeto, melhorando a eficiência e a visibilidade dos testes de performance.
