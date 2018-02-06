tree = ["A",
            ["B",
                ["X", nil, nil],
                nil
            ],
            ["C",
                ["D", nil, nil],
                ["E", nil, nil]
            ]
       ]

class TreeTraversals

  def depth_first_aux(node)
    if !node.nil?
      @yielder << node[0]
      depth_first_aux(node[1])
      depth_first_aux(node[2])
    end
  end

  def depth_first(tree)
    Enumerator.new do |yielder|
      @yielder = yielder
      depth_first_aux(tree)
    end
  end
end

tt = TreeTraversals.new
e = tt.depth_first(tree)
e.each {|x| p x}

