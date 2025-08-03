#!/bin/bash

## fix excess locales
echo -e "en_US.UTF-8 UTF-8\nfa_IR.UTF-8 UTF-8" | sudo tee /etc/locale.gen > /dev/null
sudo rm -rf /usr/lib/locale/* /var/lib/locales/supported.d/*
sudo locale-gen

