# Crashy

Here's your chance to inflict chaos and destruction on
your Elixir runtime.

The GenServer `CrashyMcCrashFace` has two API functions, `crash` and
`exit`.

If you call `exit`, the server does a normal exit. If you call
`crash`, it exits with an error.

The top-level of the application, in `lib/crashy.ex,` starts three
copies of McCrashFace, with the names `:one`, `:two`, and `:three`.

These three workers are supervised.

You can run the application and call either `exit` or `crash` with:

~~~
mix run -e "Crashy.McCrashFace.exit  :two"
mix run -e "Crashy.McCrashFace.crash :two"
~~~

When you do so, the app will trace what happens—you'll see workers
terminate and possibly restart:

Your Mission
============

Change the values of the `:strategy` and `:restart` options in
`lib/crashy.ex`. There are nine combinations in all. For each, run

~~~
mix run -e "Crashy.McCrashFace.exit  :two"
mix run -e "Crashy.McCrashFace.crash :two"
~~~

and record in the following table which workers are stopped by each
command, and which workers are subsequently restarted. I've filled in
some entries for you. I show workers that are terminated using `-` and
a list of numbers, and those that are subsequently restarted using `+`
and their numbers


| restart   | call  | one_for_one | one_for_all | rest_for_one |
| --------- | ----- | ----------- | ----------- | ------------ |
| permanent | exit  |  -2   +2    |  -231 +123  |  -23 +23     |
|           | crash |  -2   +2    |  -231 +123  |  -23 +23     |
|           |       |             |             |              |
| transient | exit  |  -2         |  -2         |  -2          |
|           | crash |  -2 +2      |  -123 +123  |  -23 +23     |
|           |       |             |             |              |
| temporary | exit  |  -2         |  -2         | -2           |
|           | crash |  -2         |  -2         | -2           |

