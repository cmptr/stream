#!/bin/bash
set -x
spin()
{
  spinner="/|\\-/|\\-"
  while :
  do
    for i in `seq 0 7`
    do
      echo -n "${spinner:$i:1}"
      echo -en "\010"
      sleep 1
    done
  done
}

echo "Booting"

# Start the Spinner:
spin &
# Make a note of its Process ID (PID):
SPIN_PID=$!
# Kill the spinner on any signal, including our own exit.
trap "kill -9 $SPIN_PID" `seq 0 15`

# http://slowwly.robertomurray.co.uk/ is a useful
# webservice - it is deliberately slow!
curl -L http://slowwly.robertomurray.co.uk/delay/15000/url/https://www.shellscript.sh/tips/spinner/test.txt

echo "stream initialized"

# If the script is going to exit here, there is nothing to do.
# The trap above will kill the spinner when this script exits.
# Otherwise, if the script is going to do more stuff, you can
# kill the spinner now:
kill -9 $SPIN_PID

