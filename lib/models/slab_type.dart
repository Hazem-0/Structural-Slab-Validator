enum SlabType {
  oneWay('One way slab'),
  twoWay('Two way slab'),
  invalid('Invalid design');

  final String value;
  const SlabType(this.value);
}
