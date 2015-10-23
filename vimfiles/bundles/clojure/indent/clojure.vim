"Basically, I'm using the default LISP indenting, with a few extra keywords.

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

setlocal ai nosi

let b:undo_indent = "setl ai< si<"

setlocal lisp

" Defintions:
setlocal lispwords=def,def-,defn,defn-,defmacro,defmacro-,defmethod,defmulti
setlocal lispwords+=defonce,defvar,defvar-,defunbound,let,fn,letfn,binding,proxy
setlocal lispwords+=defnk,definterface,defprotocol,deftype,defrecord,reify
setlocal lispwords+=extend,extend-protocol,extend-type,bound-fn

" Conditionals and Loops:
setlocal lispwords+=if,if-not,if-let,when,when-not,when-let,when-first
setlocal lispwords+=condp,case,loop,dotimes,for,while

" Blocks:
setlocal lispwords+=do,doto,try,catch,locking,with-in-str,with-out-str,with-open
setlocal lispwords+=dosync,with-local-vars,doseq,dorun,doall,->,->>,future
setlocal lispwords+=with-bindings

" Namespaces:
setlocal lispwords+=ns,clojure.core/ns

" Java Classes:
setlocal lispwords+=gen-class,gen-interface
