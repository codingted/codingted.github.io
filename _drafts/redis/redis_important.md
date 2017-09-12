# server.h 

```
  {"get",getCommand, 2,     "rF",   0,     NULL,         1,                 1,              1,             0,          0}
//   ^         ^      ^       ^      ^       ^            ^                  ^               ^              ^           ^
// name    function arity   sflag   flags get_keys_proc  first_key_index    last_key_index key_step   microseconds   calls


{"mset",msetCommand,-3,"wm",0,NULL,1,-1,2,0,0},
```

name: a string representing the command name.
function: pointer to the C function implementing the command.
arity: number of arguments, it is possible to use -N to say >= N
sflags: command flags as string. See below for a table of flags.
flags: flags as bitmask. Computed by Redis using the 'sflags' field.
get_keys_proc: an optional function to get key arguments from a command.
               This is only used when the following three fields are not
               enough to specify what arguments are keys.
first_key_index: first argument that is a key
last_key_index: last argument that is a key
key_step: step to get all the keys from first to last argument. For instance
          in MSET the step is two since arguments are key,val,key,val,...
microseconds: microseconds of total execution time for this command.
calls: total number of calls of this command.

w: write command (may modify the key space).
r: read command  (will never modify the key space).
m: may increase memory usage once called. Do not allow if out of memory. 
a: admin command, like SAVE or SHUTDOWN.
p: Pub/Sub related command.
f: force replication of this command, regardless of server.dirty.
s: command not allowed in scripts.
R: random command. Command is not deterministic, that is, the same command
   with the same arguments, with the same key space, may have different
   results. For instance SPOP and RANDOMKEY are two random commands.
S: Sort command output array if called from script, so that the output
   is deterministic.
l: Allow command while loading the database.
t: Allow command while a slave has stale data but is not allowed to
   server this data. Normally no command is accepted in this condition
   but just a few.
M: Do not automatically propagate the command on MONITOR.
k: Perform an implicit ASKING for this command, so the command will be
   accepted in cluster mode if the slot is marked as 'importing'.
F: Fast command: O(1) or O(log(N)) command that should never delay
   its execution as long as the kernel scheduler is giving us time.
   Note that commands that may trigger a DEL as a side effect (like SET)
   are not fast commands.
