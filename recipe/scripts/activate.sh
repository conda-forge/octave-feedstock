export OCTAVE_HOME_CONDA_BACKUP=${OCTAVE_HOME:-}
export OCTAVE_HOME=$CONDA_PREFIX

# Rebuild Octave global package registry so globally installed
octave --eval "pkg rebuild -global"
