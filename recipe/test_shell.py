#!/usr/bin/env python
#
# Test for a bug where fish-shell will hang when launched interactively.
#
# This tests for a regression reported in
# https://github.com/conda-forge/fish-feedstock/issues/58

import os
import sys
import time

import pexpect

# fish-shell outputs terminal escape sequences which can mess up the
# prompt. Force fish-shell to use a fixed terminal that has minimal
# escape sequences.
print("Spawning interactive fish shell")
fish = pexpect.spawn(
    "fish -N", logfile=sys.stdout.buffer, env=os.environ | {"TERM": "xterm-256color"}
)

print("Waiting for fish prompt...")
index = fish.expect_exact(["#", ">", pexpect.EOF, pexpect.TIMEOUT])
if index in [0, 1]:
    print("Found fish prompt")
else:
    sys.exit("ERROR: Timed out waiting for fish prompt")

time.sleep(5)

print("Sending command to fish")
fish.sendcontrol("c")
fish.send("echo hel''lo\n")
fish.send("echo hel''lo\n")

print("Waiting for command response...")
index = fish.expect_exact(["hello", pexpect.EOF, pexpect.TIMEOUT])
if index == 0:
    print("Found command response")
else:
    print(str(fish))
    sys.exit("ERROR: Timed out waiting for command response")
