# cython: language_level=3


from . cimport uv

from libc.stdint cimport uint64_t


cdef class BaseHandle
cdef class Async(BaseHandle)
cdef class Timer(BaseHandle)
cdef class Signal(BaseHandle)
cdef class Idle(BaseHandle)


cdef class Loop:
    cdef:
        uv.uv_loop_t *loop
        int _closed
        int _debug
        long _thread_id
        int _running

        object _ready
        int _ready_len
        object _timers

        Async handler_async
        Idle handler_idle
        Signal handler_sigint

        object _last_error

        cdef object __weakref__

    cdef _run(self, uv.uv_run_mode)
    cdef _close(self)
    cdef _stop(self)
    cdef uint64_t _time(self)

    cdef _call_soon(self, object callback)
    cdef _call_later(self, uint64_t delay, object callback)

    cdef void _handle_uvcb_exception(self, object ex)
    cdef _handle_uv_error(self, int err)

    cdef _check_closed(self)
    cdef _check_thread(self)


include "handle.pxd"
include "async_.pxd"
include "idle.pxd"
include "timer.pxd"
include "signal.pxd"
