# ArcoNorte Nexus - Landing Page

Esta subpasta contém os arquivos públicos da landing page do **ArcoNorte Nexus**, servida via GitHub Pages da THP DeepTech & Systems (`thpinteligencia.github.io/arconorte-nexus`).

## Estrutura
O código-fonte principal da aplicação analítica completa e os dados de treinamento de IA do modelo LSTM residem em um repositório privado separado (`arconorte-nexus`). Apenas os arquivos HTML, CSS e JS estáticos e sanitizados necessários para a landing page institucional e o simulador interativo do IPE são publicados aqui de forma pública.

## Atualização Automatizada
Para atualizar esta página com as últimas alterações feitas na pasta `docs/` do repositório privado, utilize o script de importação automatizada disponível nesta pasta:

```bash
./import_page.sh
```

O script executará as seguintes etapas de forma automática:
1. Puxar as últimas alterações da branch `main` do repositório do site (`thpinteligencia.github.io`).
2. Sincronizar de forma limpa os arquivos de origem a partir da pasta `docs/` do repositório local `arconorte-nexus`.
3. Ajustar os links na barra de navegação, substituindo a referência ao repositório privado pelo link de retorno ao portfólio da THP DeepTech & Systems (`../`).
4. Fazer o commit e push automáticos para a branch `main` do repositório público, disponibilizando as atualizações no ar imediatamente.

---
*Uma iniciativa da [THP DeepTech & Systems](https://thp.inteligencia.com.br)*
