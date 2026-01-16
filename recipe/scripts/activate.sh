export OCTAVE_HOME_CONDA_BACKUP=${OCTAVE_HOME:-}
export OCTAVE_HOME=$CONDA_PREFIX

# Rebuild Octave global package registry so globally installed Octave Forge packages are discoverable in fresh environments
octave --eval "pkg rebuild -global"
