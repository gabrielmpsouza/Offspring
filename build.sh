#!/bin/bash

# Move o conteúdo de ~/Offspring/source para /
mv ~/Offspring/source/* /

# Move o script ~/Offspring/offspring.sh para /usr/local/bin
mv ~/Offspring/offspring /usr/local/bin
mv ~/Offspring/offspring-english /usr/local/bin

# Dá permissão de execução para o script em /usr/local/bin
chmod +x /usr/local/bin/offspring
chmod +x /usr/local/bin/offspring-english
