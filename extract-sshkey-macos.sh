#!/bin/bash
set -e
cd ~/.ssh
echo "Inserta tu YubiKey y toca el dispositivo cuando se te pida."
ssh-keygen -K
echo "Claves SSH extraídas desde la YubiKey."
