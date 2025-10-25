#!/usr/bin/env bash
# Esegue paru -Syu in kitty e si chiude automaticamente al termine.
# Se ci sono prompt (es. [Y/n]), si bloccherà in attesa.
kitty sh -c "paru -Syu"
