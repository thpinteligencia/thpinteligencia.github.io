# Instruções de Publicação e Atualização da Landing Page

Este diretório contém a landing page moderna, responsiva e de alta conversão para o **Lavrado Express**. A página está publicada na subpasta `/lavrado-express/` do site principal.

O endereço oficial da landing page é:
👉 **[https://thpinteligencia.github.io/lavrado-express/](https://thpinteligencia.github.io/lavrado-express/)**

---

## Como Atualizar a Landing Page

Como o repositório principal do código do Lavrado Express é privado e contém propriedade intelectual confidencial, a landing page é mantida separada e importada para este repositório público usando o script automatizado `import_page.sh`.

### Método Recomendado: Usar o Script de Importação

Se você fez alterações no código da landing page no repositório de desenvolvimento (ex: `/home/hiago/Workspace/THP/Lavrado Express/landing/`), siga os passos abaixo para atualizar o site oficial:

1. Abra o terminal.
2. Navegue até a pasta onde este script está localizado (`lavrado-express/`).
3. Execute o script `import_page.sh` passando o diretório de origem da landing page compilada e o nome da pasta destino:

```bash
# Torne o script executável (caso necessário)
chmod +x import_page.sh

# Execute a importação
./import_page.sh "/caminho/para/seu/projeto-lavrado/landing" "lavrado-express"
```

### O que o Script faz automaticamente:
1. Identifica dinamicamente a raiz do repositório `thpinteligencia.github.io`.
2. Garante que os arquivos locais estão atualizados com o GitHub (`git pull`).
3. Limpa os arquivos antigos na subpasta `lavrado-express/` (preservando o próprio script e este README).
4. Copia os novos arquivos atualizados.
5. Adiciona, faz commit e envia as atualizações para o GitHub (`git push`).

*Última atualização desta documentação: 02 de julho de 2026.*
