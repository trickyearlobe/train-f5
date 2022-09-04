# frozen_string_literal: true

# Set up the search path for requires
libdir = __dir__
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

# Pull in the rest of the libraries
require "train-f5/transport"
