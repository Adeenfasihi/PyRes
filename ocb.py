#!/usr/bin/env python3
# ----------------------------------
#
# Module ocb.py

"""

"""
import unittest

from terms import *


class OCBCell:
    def __init__(self, term, weights=None, var_weight=None):

        self.ocb_funs = {}
        self.ocb_vars = {}

        self.insert2dic(term, weights, var_weight)
        self.sig_size = len(self.ocb_funs)
        #self.nextcell = None

    def insert2dic(self, term, weights=None, var_weights=None):
        if var_weights is None:
            var_weights = [1] * len(termCollectVars(term))
        elif len(termCollectVars(term)) - len(var_weights) != 0:
            print("weights and vars don't match")
            assert False
        if weights is None:
            weights = [1] * len(termCollectFuns(term))
        elif len(termCollectFuns(term)) - len(weights) != 0:
            print("weights and funs don't match")
            assert False
        for idx,fun in enumerate(termCollectFuns(term)):
            self.ocb_funs.update({fun: weights[idx]})
        for idx,var in enumerate(termCollectVars(term)):
            self.ocb_vars.update({var: var_weights[idx]})


"""
class LinkedList:
    def __init__(self, initocbcell=None):
        self.initOCBCell = initocbcell


    def append(self, cell):
        if not self.initOCBCell:
            self.initOCBCell = cell
        else:
            last_cell = self.initOCBCell
            while last_cell.nextcell:
                last_cell = last_cell.nextcell
            last_cell.nextcell = cell

"""

class TestOCB(unittest.TestCase):
    """
    Test basic ocb functions.
    """
    def setUp(self):
        self.example1 = "g(X, f(b))"
        self.t1 = string2Term(self.example1)
        self.example2 = "g(X, h(b))"
        self.t2 = string2Term(self.example2)
        self.ocb = OCBCell(self.t1,None,None)
    def testOCB(self):
        self.assertTrue(self.ocb.sig_size == 3)
        self.assertEqual(self.ocb.ocb_funs.keys(), {"b", "f", "g"})
        self.assertEqual(self.ocb.ocb_vars.keys(), {'X'})
        print(self.ocb.ocb_funs.values())
        print(self.ocb.ocb_funs)
        print(self.ocb.ocb_vars)
        self.ocb.insert2dic(self.t2)
        self.assertEqual(self.ocb.ocb_funs.keys(), {"b", "f", "g", "h"})
        self.assertEqual(self.ocb.ocb_vars.keys(), {'X'})
        print(self.ocb.ocb_funs)

        #self.ocb1 = OCBCell(1, [1, 1], 1)
        #self.ocb2 = OCBCell(2)
        #self.ocb1.nextcell = self.ocb2
        #self.list = LinkedList(self.ocb1)
        #self.assertTrue(self.ocb1.weights == [1, 1])
        #self.assertTrue(self.ocb1.nextcell.sig_size == 2)
        #self.assertTrue(self.list.initOCBCell.nextcell.sig_size == 2)


if __name__ == '__main__':
    unittest.main()
