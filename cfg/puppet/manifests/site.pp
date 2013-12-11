# This is the base setup of our architecture.
# Anything that is global for all systems should
# go in the basic-setup.pp file 
import "basic-setup.pp"

# Import the patterns
import "patterns/*.pp"

# Import the definitions of the various systems
import "nodes/*.pp"
