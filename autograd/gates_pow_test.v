module autograd

import vtl

fn test_pow() {
	f64_ctx := ctx<f64>()

	x := f64_ctx.variable(vtl.from_1d([3.0]) or { panic(@FN + ' failed') })
	y := f64_ctx.variable(vtl.from_1d([2.0]) or { panic(@FN + ' failed') })

	mut f := x.pow(y) or { panic(@FN + ' failed') }

	f.backprop() or { panic(@FN + ' failed') }

	assert x.grad.array_equal(vtl.from_1d([6.0]) or { panic(@FN + ' failed') })
}
