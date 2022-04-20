#-------------------------------------------------------------------------------
# Name:         module1
# Purpose:      Creation of road network specific maximum
#               worksite length constraint matrix parts
#
# Authors:      Silvan Sigrist
#               Manuel Sigrist
#
# Created:      28.11.2012
# Copyright:    (c) Silvan Sigrist, 2012
#               (c) Manuel Sigrist, 2012
# License:      For personal, non-commercial use only
#               Do not publish without authors permission
#-------------------------------------------------------------------------------
#!/usr/bin/env python

import json

class Node(object):
    def __init__(self, id, value):
        self.children = set([])
        self.value = value
        self.id = id
        self.parent = None

    def add(self, node):
        if node:
            self.children.add(node)
            node.parent = self

    def findById(self, id):
        if self.id == id:
            return self
        for child in self.children:
            res = child.findById(id)
            if res:
                return res
        return None

    def __str__(self):
        return str(self.id) + '=' + str(self.value)

    def traverseBack(self, maxVal, debug=False):
        length = 1
        parent = self.parent
        while parent:
            length += 1
            parent = parent.parent
        for i in xrange(0, length):
            res = []
            for y in xrange(0, i):
                res.append('0')
            parent = self
            y = 0
            while not parent.parent is None and y < i:
                parent = parent.parent
                y+=1
            tVal = maxVal
            running = True
            while not parent is None:
                if running:
                    if debug:
                        res.append(str(parent))
                    else:
                        res.append(str(parent.value))
                    tVal -= parent.value
                    if tVal < 0:
                        running = False
                else:
                    res.append('0')
                parent = parent.parent
            res.reverse()
            print ', '.join(res)



def main():

    nodes = []
    with open('nodes.csv', 'r') as f:
        raw = json.load(f)
        for nodedata in raw:
            nodes.append(Node(nodedata[0], nodedata[1]))

    #alle aeste erstellen
    root = nodes[0]
    for i in xrange(0, 17):
        nodes[i].add(nodes[i+1])
    for i in xrange(18, 38):
        nodes[i].add(nodes[i+1])
    for i in xrange(39, 61):
        nodes[i].add(nodes[i+1])
    for i in xrange(62, 74):
        nodes[i].add(nodes[i+1])
    for i in xrange(75, 93):
        nodes[i].add(nodes[i+1])
    for i in xrange(94, 121):
        nodes[i].add(nodes[i+1])
    for i in xrange(122, 145):
        nodes[i].add(nodes[i+1])
    for i in xrange(146, 154):
        nodes[i].add(nodes[i+1])
    for i in xrange(155, 159):
        nodes[i].add(nodes[i+1])

    #alle aeste aneinanderhaengen
    n = root.findById('006')
    n.add(nodes[18])
    n = root.findById('004')
    n.add(nodes[39])
    n = root.findById('054')
    n.add(nodes[62])
    n = root.findById('066')
    n.add(nodes[75])
    n = root.findById('078')
    n.add(nodes[94])
    n = root.findById('100')
    n.add(nodes[122])
    n = root.findById('137')
    n.add(nodes[146])
    n = root.findById('152')
    n.add(nodes[155])



    #n = root.findById('155')
    #print n
    #n.traverseBack(8, True)

    #matrix erstellen
    n = root.findById('018')
    n.traverseBack(10)
    n = root.findById('039')
    n.traverseBack(10)
    n = root.findById('062')
    n.traverseBack(10)
    n = root.findById('075')
    n.traverseBack(10)
    n = root.findById('094')
    n.traverseBack(10)
    n = root.findById('122')
    n.traverseBack(10)
    n = root.findById('146')
    n.traverseBack(10)
    n = root.findById('155')
    n.traverseBack(10)
    n = root.findById('160')
    n.traverseBack(10)


if __name__ == '__main__':
    main()
