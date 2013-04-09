
#include "captureoutput.h"

static void (*stdout_write_callback)(VALUE);

static VALUE object_captured_write(VALUE c, VALUE str) {
    if (stdout_write_callback) {
        stdout_write_callback(rb_obj_as_string(str));
    }
    return Qnil;
}

void init_captureoutput(void (*write_callback)(VALUE str)) {
    stdout_write_callback = write_callback;
    rb_define_method(rb_cObject, "captured_write", object_captured_write, 1);
    rb_require("captureoutput");
}

