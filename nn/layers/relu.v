module layers

import vtl
import vtl.autograd
import vtl.nn.internal
import vtl.nn.gates.activation
import vtl.nn.types

// ReLULayer is a layer that applies the rectified linear unit function element-wise.
pub struct ReLULayer[T] {
	output_shape []int
}

pub fn relu_layer[T](ctx &autograd.Context[T], output_shape []int) types.Layer[T] {
	return types.Layer[T](&ReLULayer[T]{
		output_shape: output_shape.clone()
	})
}

pub fn (layer &ReLULayer[T]) output_shape() []int {
	return layer.output_shape
}

pub fn (_ &ReLULayer[T]) variables() []&autograd.Variable[T] {
	return []&autograd.Variable[T]{}
}

pub fn (layer &ReLULayer[T]) forward(mut input autograd.Variable[T]) !&autograd.Variable[T] {
	output := internal.relu[T](input.value)
	mut result := input.context.variable(output)

	if input.requires_grad {
		gate := activation.relu_gate[T](input.value)
		gate.cache(mut result, input)!
	}
	return result
}
