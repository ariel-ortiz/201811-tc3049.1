tree = ["A",
            ["B",
                ["X", 
                    ["Y", nil, nil], 
                    nil
                ],
                nil
            ],
            ["C",
                ["D", 
                    nil,
                    ["Z", nil, nil]
                ],
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
  
  def breadth_first(tree)
    Enumerator.new do |yielder|
      queue = [tree]
      while !queue.empty?
        e = queue.shift
        if !e.nil?
          yielder << e[0]
          queue << e[1]
          queue << e[2]
        end
      end
    end
  end
end

tt = TreeTraversals.new
e = tt.breadth_first(tree)
e.each {|x| p x}
