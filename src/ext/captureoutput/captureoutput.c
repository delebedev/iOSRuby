
#include "captureoutput.h"

static void (*stdout_write_callback)(VALUE);

static VALUE (*stdin_read_callback)(void);

static VALUE object_captured_write(VALUE c, VALUE str) {
    if (stdout_write_callback) {
        stdout_write_callback(rb_obj_as_string(str));
    }
    return Qnil;
}

static VALUE object_captured_read(void) {
	if (stdin_read_callback)
	{
		return stdin_read_callback();
	}
	return Qnil;
}

void init_captureoutput(void (*write_callback)(VALUE str), VALUE (*stdin_read_callback)(void)) {
    stdout_write_callback = write_callback;
    rb_define_method(rb_cObject, "captured_write", object_captured_write, 1);
    b_define_method(rb_cObject, "captured_read",  object_captured_read, 0);
    rb_require("captureoutput");
}

