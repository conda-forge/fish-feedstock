#!/usr/bin/env python
#
# Test for a bug where fish-shell will hang when launched interactively.
#
# This tests for a regression reported in
# https://github.com/conda-forge/fish-feedstock/issues/58

import pexpect
import sys
import time

print("Spawning interactive fish shell")
fish = pexpect.spawn('fish -N', logfile=sys.stdout.buffer)

print("Waiting for fish prompt...")
index = fish.expect_exact(["#", ">", pexpect.EOF, pexpect.TIMEOUT])
if index in [0, 1]:
    print("Found fish prompt")
else:
    sys.exit("ERROR: Timed out waiting for fish prompt")

time.sleep(5)

print("Sending command to fish")
fish.sendline("echo hel''lo")

print("Waiting for command response...")
index = fish.expect_exact(["hello", pexpect.EOF, pexpect.TIMEOUT])
if index == 0:
    print("Found command response")
else:
    print(str(fish))
    sys.exit("ERROR: Timed out waiting for command response")
