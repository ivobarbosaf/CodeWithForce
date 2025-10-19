# Salesforce Development Project

Este projeto está configurado para desenvolvimento Salesforce usando VS Code, Salesforce Extensions e SFDX CLI.

## Configuração da Org

**Org Conectada:**

- Username: `ivobarbosaf663@agentforce.com`
- Alias: `MyOrg`
- Instance URL: `https://orgfarm-c713d456af-dev-ed.develop.my.salesforce.com`
- API Version: `65.0`
- Status: Conectada ✅

## Estrutura do Projeto

```
├── force-app/main/default/    # Código fonte principal
│   ├── classes/              # Apex Classes
│   ├── lwc/                  # Lightning Web Components
│   ├── triggers/             # Apex Triggers
│   └── ...                   # Outros metadados
├── config/                   # Configurações do projeto
├── scripts/                  # Scripts de desenvolvimento
├── .vscode/                  # Configurações do VS Code
└── sfdx-project.json        # Configuração do projeto SFDX
```

## Comandos Principais

### Recuperar Metadados da Org

```bash
# Recuperar todos os metadados
sf project retrieve start

# Recuperar componentes específicos
sf project retrieve start --metadata ApexClass:MyClass
```

### Deploy para a Org

```bash
# Deploy de todo o projeto
sf project deploy start

# Deploy de componente específico
sf project deploy start --source-dir force-app/main/default/classes/MyClass.cls
```

### Trabalhar com Componentes

```bash
# Criar nova Apex Class
sf apex generate class --name MyNewClass --output-dir force-app/main/default/classes

# Criar novo Lightning Web Component
sf lightning generate component --name myComponent --type lwc --output-dir force-app/main/default/lwc
```

### Executar Testes

```bash
# Executar todos os testes
sf apex run test

# Executar teste específico
sf apex run test --tests MyTestClass
```

## Próximos Passos

1. **Recuperar Metadados Existentes**: Execute `sf project retrieve start` para baixar os metadados da sua org
2. **Explorar o Código**: Navegue pelos metadados baixados em `force-app/main/default/`
3. **Fazer Alterações**: Edite os componentes existentes ou crie novos
4. **Deploy das Alterações**: Use `sf project deploy start` para enviar suas mudanças

## Recursos Úteis

- [Salesforce Extensions for VS Code](https://forcedotcom.github.io/salesforcedx-vscode/)
- [Salesforce CLI Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/)
- [Apex Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/)
- [Lightning Web Components Guide](https://developer.salesforce.com/docs/component-library/documentation/en/lwc)
