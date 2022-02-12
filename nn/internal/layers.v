module internal

import vtl

pub fn maxpool<T>(input &vtl.Tensor<T>, kernel []int, padding []int, stride []int) (&vtl.Tensor<int>, &vtl.Tensor<T>) {
	nn := input.shape[0]
	cc := input.shape[1]
	hh := input.shape[2]
	ww := input.shape[3]

	kk := kernel[0]
	kw := kernel[1]

	outh := (hh + 2 * padding[0] - kk) / stride[0] + 1
	outw := (ww + 2 * padding[1] - kw) / stride[1] + 1

	max_indices := vtl.zeros<int>([n, cc, outh, outw])
	output := vtl.zeros<T>([n, cc, outh, outw])

	// @todo: Implement maxpool here

	return max_indices, output
}

pub fn maxpool_backward<T>(shape []int, max_indices &vtl.Tensor<int>, grad_output &vtl.Tensor<T>) {
	if grad_output.size != max_indices.size {
		panic('maxpool_backward: grad_output and max_indices must have the same size')
	}

	mut ret := vtl.zeros<T>(shape)
	for i in 0 .. grad_output.size {
		idx := max_indices.data[i]
		ret.data.set<T>(idx, grad_output.data[i])
	}
	return ret
}
