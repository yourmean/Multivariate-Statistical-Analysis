data headsize;
input first_son	second_son;
cards;
191	179
181	185
176	171
189	190
188	197
179	186
174	186
188	187
195	183
181	182
192	185
176	176
190	187
195	201
183	188
208	192
197	189
192	187
183	174
190	195
163	161
186	173
175	165
174	178
197	200
;
proc print data=headsize; run; quit;

proc princomp data = headsize out = headsize_comp;
run; quit;
